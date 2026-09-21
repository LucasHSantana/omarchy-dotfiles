-- Extra autostart processes.
-- o.launch_on_start("my-service")
o.launch_on_start("trayscale --hide-window")
o.launch_on_start(os.getenv("HOME") .. "/.config/hypr/scripts/start_openrgb.sh")
