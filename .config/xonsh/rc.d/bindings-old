@events.on_ptk_create
def _custom_keybindings(bindings, **kw):
    from prompt_toolkit.key_binding.bindings.named_commands import get_by_name
    import prompt_toolkit.input.ansi_escape_sequences as ansiseq
    from prompt_toolkit.keys import Keys
    from prompt_toolkit.filters import EmacsInsertMode, ViInsertMode
    from xonsh.platform import ON_WINDOWS

    insert_mode = ViInsertMode() | EmacsInsertMode()

    @bindings.add(Keys.ControlDelete, filter=insert_mode)
    def delete_big_word(event):
        buff = event.current_buffer
        pos = buff.document.find_next_word_ending(count=event.arg, WORD=True)
        if pos:
            buff.delete(count=pos)

    @bindings.add(Keys.Escape, Keys.Delete, filter=insert_mode)
    def delete_small_word(event):
        get_by_name("kill-word").call(event)

    # PTK sets both "\x7f" (^?) and "\x08" (^H) to the same behavior. Refs:
    # https://github.com/prompt-toolkit/python-prompt-toolkit/blob/65c3d0607c69c19d80abb052a18569a2546280e5/src/prompt_toolkit/input/ansi_escape_sequences.py#L65
    # https://github.com/prompt-toolkit/python-prompt-toolkit/issues/257#issuecomment-190328366
    # We patch the ANSI sequences used by PTK.  This requires a terminal
    # that sends different codes for <backspace> and <control-h>.
    # PTK sets Keys.Backspace = Keys.ControlH, so we hardcode the code.
    # Windows has the codes reversed, see https://github.com/xonsh/xonsh/commit/406d20f78f18af39d9bbaf9580b0a763df78a0db
    if XSH.env.get("XONSH_WHOLE_WORD_CTRL_BKSP", True):
        import prompt_toolkit.input.ansi_escape_sequences as ansiseq
        from xonsh.platform import ON_WINDOWS

        CONTROL_BKSP = "\x08"
        if ON_WINDOWS:
            # On windows BKSP is "\x08" and CTRL-BKSP is "\x7f"
            CONTROL_BKSP = "\x7f"
            from prompt_toolkit.input import win32 as ptk_win32
            ptk_win32.ConsoleInputReader.mappings[b"\x7f"] = CONTROL_BKSP
        ansiseq.ANSI_SEQUENCES[CONTROL_BKSP] = CONTROL_BKSP
        ansiseq.REVERSE_ANSI_SEQUENCES[CONTROL_BKSP] = CONTROL_BKSP

        @bindings.add(CONTROL_BKSP, filter=insert_mode)
        def backward_delete_big_word(event):
            get_by_name("unix-word-rubout").call(event)

    # backward_delete_small_word works on Alt+Backspace by default
