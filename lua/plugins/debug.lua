-- lua/plugins/debug_flask.lua
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dap_python = require("dap-python")

      -- Function to ensure debugpy is installed in the active Python environment
      local function ensure_debugpy(python_path)
        local handle = io.popen(python_path .. " -m pip show debugpy 2>/dev/null")
        local output = handle:read("*a")
        handle:close()

        if output == "" then
          print("Installing debugpy for: " .. python_path)
          os.execute(python_path .. " -m pip install --quiet debugpy")
        end
      end

      -- Function to load environment variables from a .env file
      local function load_env_file()
        local env_file_path = vim.fn.getcwd() .. "/.env"
        local env_vars = {}

        -- Check if .env file exists
        if vim.fn.filereadable(env_file_path) == 1 then
          for line in io.lines(env_file_path) do
            -- Ignore comments and empty lines
            if not line:match("^%s*#") and line:match("=") then
              local key, value = line:match("^(.-)=(.*)$")
              if key and value then
                env_vars[key] = value:gsub("%s+", "") -- Trim whitespace
              end
            end
          end
        else
          print(".env file not found: " .. env_file_path)
        end

        return env_vars
      end

      -- Attempt to get the active Python interpreter from the virtual environment
      local python_interpreter = vim.fn.system("which python"):gsub("%s+", "")

      if python_interpreter == "" then
        print("No Python interpreter found. Make sure your virtual environment is activated.")
        return
      end

      -- Ensure debugpy is installed
      ensure_debugpy(python_interpreter)

      -- Set up dap-python with the active Python interpreter
      dap_python.setup(python_interpreter)

      -- Load environment variables from .env file
      local env_vars = load_env_file()

      -- Configure the Flask debugging configuration
      dap.configurations.python = {
        {
          type = "python", -- The type of the dap configuration
          request = "launch",
          name = "Flask",
          module = "app.run", -- Use module instead of program
          args = { "-m", "flask", "run" }, -- Change to use Flask CLI
          env = vim.tbl_extend("force", { FLASK_APP = vim.fn.getcwd() }, env_vars), -- Combine environment variables
          console = "integratedTerminal",
        },
      }

      -- Map a keybinding to start the debugger easily
      vim.api.nvim_set_keymap(
        "n",
        "<leader>dd",
        ':lua require("dap").continue()<CR>',
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    opts = {},
  },
}
