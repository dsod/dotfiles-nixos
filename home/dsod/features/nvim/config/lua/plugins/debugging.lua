return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/lazy/vscode-php-debug/out/phpDebug.js" },
      }
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      dap.configurations.php = {
        {
          type = "php",
          request = "launch",
          name = "[php] Attach /var/www/html",
          port = 9003,
          hostname = "0.0.0.0",
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}",
          },
        },
        {
          type = "php",
          request = "launch",
          name = "[php] Attach /qbank3",
          port = 9003,
          hostname = "0.0.0.0",
          pathMappings = {
            ["/qbank3"] = "${workspaceFolder}",
          },
        },
        {
          type = "php",
          request = "launch",
          name = "[php] Attach /jobqueue",
          port = 9003,
          hostname = "0.0.0.0",
          pathMappings = {
            ["/jobqueue"] = "${workspaceFolder}",
          },
        },

        {
          name = "[php] Launch file",
          type = "php",
          request = "launch",
          program = "${file}",
          cwd = "${fileDirname}",
          port = 0,
          runtimeArgs = { "-dxdebug.start_with_request=yes" },
          env = {
            XDEBUG_MODE = "debug,develop",
            XDEBUG_CONFIG = "client_port=${port}",
          },
          ignoreExceptions = { "IgnoreException" },
        },
      }
      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        -- works with go.mod packages and sub packages
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }
    end,
    dependencies = {
      { "jay-babu/mason-nvim-dap.nvim", enable = false },
    },
    keys = {
      {
        "<F6>",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<F5>",
        function()
          require("dap").continue({ before = get_args })
        end,
        desc = "Run with Args",
      },
      {
        "<F7>",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<F23>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<F8>",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
    },
  },
  {
    "xdebug/vscode-php-debug",
    build = "npm install && npm run build",
  },
}
