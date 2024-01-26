local utils = require("new-file-template.utils")

local function base_template(relative_path, filename)
	return [[
{
  |cursor|
}]]
end

local function jupyter_notebook(relative_path, filename)
	return [[
{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "de761d06-8636-43bd-94cf-9a8ba1be3e30",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.11.5"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}]]
end

--- @param opts table
---   A table containing the following fields:
---   - `full_path` (string): The full path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `relative_path` (string): The relative path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `filename` (string): The filename of the new file, e.g., "init.lua".
return function(opts)
	local template = {
		{ pattern = ".ipynb", content = jupyter_notebook },
		{ pattern = ".*", content = base_template },
	}

	return utils.find_entry(template, opts)
end
