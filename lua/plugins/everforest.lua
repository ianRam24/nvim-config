return{
  'sainnhe/everforest',
  lazy = false,
  priority = 1000,
  config = function()
    -- Habilitar cursiva en el tema
    vim.g.everforest_enable_italic = true
    -- Configurar la transparencia
    vim.g.everforest_background = 'soft'  -- O 'hard', dependiendo de tu preferencia
    vim.g.everforest_transparent_background = 1

    -- Aplicar el esquema de colores everforest
    vim.cmd.colorscheme('everforest')
  end
}
