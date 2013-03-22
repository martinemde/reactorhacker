def assets_same?
  rel = config.paths.previous_release(config.paths.active_release)
  shell.debug "Previous release path: #{rel}"
  previous_revision_path = rel && rel.join('REVISION')
  shell.debug "Previous revision path: #{previous_revision_path}"
  prev = previous_revision_path.read.strip if previous_revision_path.readable?
  shell.debug "Previous revision: #{prev}"
  if prev
    # git diff returns 0 (true) when there are no changes and 1 (false) when there are changes.
    res = run("git --git-dir #{config.paths.repository_cache} diff '#{prev}'..'#{config.active_revision}' --exit-code --name-only -- app/assets >/dev/null 2>&1")
    shell.debug "Result: #{res}"
    res
  else
    false
  end
end

if assets_same?
  shell.status "Same assets. Linking existing assets. Not compiling."
  current_assets_path = paths.shared_assets
  last_asset_path = paths.shared.join('last_assets')
  run "mkdir -p #{current_assets_path} #{last_asset_path} && ln -nfs #{current_assets_path} #{last_asset_path} #{paths.public}"
  # creating the public/assets directory will cause ey deploy to skip asset compilation.
else
  shell.status "Allowing ey deploy to compile assets fresh."
end
