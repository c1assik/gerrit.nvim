local M = {}
local curl = require("plenary.curl")

function M.get_changes()
	local response = curl.get("http://localhost:8080/changes/", {
		accept = "application/json",
		auth = "admin:Nh5ghcZ5JpMZdv9veu8LuUShxJhXD13yPjua3LoTNQ",
	})

	if response.status ~= 200 then
		print("Error fetching changes:", response.body)
		return {}
	end
	print(response.body)
	-- Gerrit API возвращает ответ с префиксом ")]}'"
	-- local json_body = response.body:gsub("^)%]%}'", "")
	-- local changes = vim.fn.json_decode(json_body)
	-- return changes
end

function M.show_changes()
	local changes = M.get_changes()

	-- Создаем новый буфер для отображения изменений
	-- local buf = vim.api.nvim_create_buf(false, true)
	-- vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	-- vim.api.nvim_buf_set_option(buf, "modifiable", false)
	--
	-- -- Заполняем буфер данными
	-- local lines = {}
	-- for _, change in ipairs(changes) do
	-- 	table.insert(lines, string.format("%s | %s | %s", change.change_id, change.subject, change.status))
	-- end
	-- vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	-- --
	-- -- -- Открываем буфер в новом окне
	-- vim.api.nvim_command("vsplit")
	-- vim.api.nvim_win_set_buf(0, buf)
end

function M.setup(opts)
	opts = opts or {}
	print("hello")
	vim.api.nvim_create_user_command("GerritChanges", function(opts)
		M.show_changes()
	end, {}) -- Здесь будет код для настройки плагина
end

return M
