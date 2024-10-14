return {
    'nvimdev/dashboard-nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    event = 'VimEnter',
    config = function()

		local logo = [[    
           ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗           
           ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║           
           ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║           
           ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║           
           ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║            
           ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝            
         ]] 
       
   
       logo = string.rep("\n", 8) .. logo .. "\n\n"
        require('dashboard').setup {
            -- config
            theme = 'doom',
            config = {
              header = vim.split(logo, "\n"), --your header
              center = {
                {
                    icon = ' ',
                    desc = ' Find File                      ',
                    key = 'f',
                    key_format = ' %s',
                    action = 'Telescope find_files'
                },
                {
                    icon = ' ',
                    desc = ' New File',
                    key = 'n',
                    key_format = ' %s',
                    action = 'ene | startinsert'
                },
                {
                    icon = ' ',
                    desc = ' Recent Files',
                    key = 'r',
                    key_format = ' %s',
                    action = 'Telescope oldfiles'
                },
                {
                    icon = '',
                    desc = ' Restore Session',
                    key = 's',
                    key_format = ' %s',
                    action = 'lua require("persistence").load({ last = true })'
                },
                {
                    icon = ' ',
                    desc = ' Quit',
                    key = 'q',
                    key_format = ' %s',
                    action = 'qa'
                },
              },
              footer = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
              end,
            }
        
        }
    end,
    
  }
