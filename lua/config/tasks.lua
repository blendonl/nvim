local map = vim.keymap.set

-- see if the file exists
function file_exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
	if not file_exists(file) then
		return {}
	end
	local lines = {}
	for line in io.lines(file) do
		lines[#lines + 1] = line
	end
	return lines
end

local buffer_number = -1

local function log(_, data)
	if data then
		vim.api.nvim_buf_set_lines(buffer_number, -1, -1, true, data)
	end
end

local function open_buffer()
	local buf = vim.api.nvim_create_buf(true, false)

	vim.bo[buf].filetype = "markdown"
	vim.bo[buf].modifiable = true
	vim.bo[buf].readonly = false
	vim.bo[buf].swapfile = false -- No swap file
	vim.cmd("vsplit")
	vim.api.nvim_win_set_buf(0, buf)

	return buf
end

local function findTasks(lines)
	local todo = {}
	local completed = {}
	local tasksWithKeys = {}
	local offset = 0

	for k, v in pairs(lines) do
		if string.find(v, "- [ ]", 1, true) then
			todo[#todo + 1] = v
			tasksWithKeys[#tasksWithKeys + 1] = { key = k, value = v }
			if offset == 0 then
				offset = k
			end
		else
			if string.find(v, "- [x]", 1, true) then
				completed[#completed + 1] = v

				tasksWithKeys[#tasksWithKeys + 1] = { key = k, value = v }
				if offset == 0 then
					offset = k
				end
			end
		end
	end

	return {
		todo = todo,
		completed = completed,
		tasksWithKeys = tasksWithKeys,
		offset = offset,
	}
end

local function getTasks(lines)
	local ts = findTasks(lines)
	local tasks = {}
	table.insert(tasks, "# TODO")
	table.insert(tasks, "")

	for k, v in pairs(ts.todo) do
		table.insert(tasks, v)
	end

	table.insert(tasks, "")
	table.insert(tasks, "# Completed")
	table.insert(tasks, "")

	for k, v in pairs(ts.completed) do
		table.insert(tasks, v)
	end

	return {
		tasks = tasks,
		ts = ts,
	}
end

local function listenForChanges(buf, lines, tasks_path)
	vim.api.nvim_buf_attach(buf, false, {
		on_lines = function(_, buf, changedtick, firstline, lastline, new_lastline, bytecount)
			-- Get the new content of the changed lines
			local modified_lines = vim.api.nvim_buf_get_lines(buf, firstline, new_lastline, false)
			local file = io.open(tasks_path, "w")
			local tasks = getTasks(lines)

			-- Update the lines in the all_lines table
			for i = 1, #modified_lines do
				for j = 1, #tasks.ts.tasksWithKeys do
					if
						string.gsub(tasks.ts.tasksWithKeys[j].value, "- %[[ x]%]", "")
						== string.gsub(modified_lines[i], "- %[[ x]%]", "")
					then
						lines[tasks.ts.tasksWithKeys[j].key] = modified_lines[i]
					end
				end
			end

			if not file then
				return
			end
			for _, l in ipairs(lines) do
				file:write(l .. "\n")
			end
			file:close()
			vim.schedule(function()
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, tasks.tasks)
			end)
		end,
	})
end

local path = vim.fn.system("tmux display-message -p '#S' ", {})
local tasks_path = "/home/notpc/notes/work/" .. string.gsub(path, "\n", "") .. "/index.md"

-- tests the functions above
local lines = lines_from(tasks_path)

map("n", "<leader>tx", function()
	local buf = open_buffer()
	local tasks = getTasks(lines)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, tasks.tasks)

	listenForChanges(buf, lines, tasks_path)
end, { desc = "Line Diagnostics" })
