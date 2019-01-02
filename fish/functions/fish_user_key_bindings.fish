function fish_user_key_bindings
    bind \e\e sudo!!
end

function sudo!!
    set cmd $history[1];
    commandline -t "sudo $cmd"
end