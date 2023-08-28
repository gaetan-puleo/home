
if(not vim.g.vscode) then
	require('settings/global')
 	require('settings/mapping')
 	require('plugin-list')
end

if(vim.g.vscode) then
  require('settings/global')
	require('settings/mapping')
end

