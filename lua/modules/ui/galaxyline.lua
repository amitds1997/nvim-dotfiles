local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}

gls.left[1] = {
  RainbowRed = {
    provider = function() return '▊ ' end,
    highlight = {colors.blue, colors.bg}
  },
}

gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {
	      n = colors.red,
	      i = colors.green,
	      v = colors.blue,
	      [''] = colors.blue,
	      V= colors.blue,
	      c = colors.magenta,
	      no = colors.red,
	      s = colors.orange,
	      S = colors.orange,
	      [''] = colors.orange,
	      ic = colors.yellow,
	      R = colors.violet,
	      Rv = colors.violet,
	      cv = colors.red,
	      ce = colors.red,
	      r = colors.cyan,
	      rm = colors.cyan,
	      ['r?'] = colors.cyan,
	      ['!']  = colors.red,
	      t = colors.red
      }
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()] ..' guibg='..colors.bg)
      return '  '
    end,
  },
}

gls.left[3] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg},
  }
}

gls.left[4] = {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    separator = ' ',
    separator_highlight = { 'NONE', colors.bg },
    highlight = {colors.fg, colors.bg, 'bold'},
  },
}

gls.left[5] = {
  MetalsStatus = {
    provider = function ()
      return vim.g['metals_status'] or ""
    end,
    highlight = {colors.green, colors.bg}
  }
}

gls.left[6] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red, colors.bg}
  },
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow, colors.bg},
  },
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.cyan, colors.bg},
  },
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue, colors.bg},
  }
}

gls.right[1] = {
  ShowLspClient = {
    provider = function ()
	    local lsp_client_name = require('galaxyline.provider_lsp').get_lsp_client()
	    if lsp_client_name == 'No Active Lsp' then
		    return ''
	    end
	    return lsp_client_name
    end,
    condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' ',
    highlight = {colors.cyan, colors.bg}
  }
}

gls.right[2] = {
  GitBranch = {
    provider = 'GitBranch',
    separator = '|',
    separator_highlight = {'NONE', colors.bg},
    condition = condition.check_git_workspace,
    highlight = {colors.violet,colors.bg,'bold'},
  }
}

gls.right[3] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.green,colors.bg},
  },
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    highlight = {colors.orange,colors.bg},
  },
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.red,colors.bg},
  }
}

gls.right[4] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = '|',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.fg, colors.bg},
  },
  PerCent = {
    provider = 'LinePercent',
    separator = '|',
    separator_highlight = {'NONE', colors.bg},
    highlight = {colors.fg, colors.bg},
  }
}

gls.right[5] = {
  RainbowBlue = {
    provider = function() return ' ▊' end,
    highlight = {colors.blue,colors.bg}
  },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = '|',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg}
  }
}
