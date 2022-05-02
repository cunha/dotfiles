@events.on_ptk_create
def _custom_keybindings(bindings, **kw):
    from prompt_toolkit.key_binding.bindings.named_commands import get_by_name
    import prompt_toolkit.input.ansi_escape_sequences as ansiseq
    from prompt_toolkit.filters import (
        Condition,
        EmacsInsertMode,
        HasSelection,
        IsMultiline,
        IsSearching,
        ViInsertMode,
    )

    insert_mode = ViInsertMode() | EmacsInsertMode()
    ansiseq.ANSI_SEQUENCES["\x08"] = "\x08"
    ansiseq.REVERSE_ANSI_SEQUENCES["\x08"] = "\x08"

    # ctrl-backspace
    @bindings.add("backspace", filter=insert_mode)
    def delete_backward_char(event):
        get_by_name("backward-delete-char").call(event)

    # alt-backspace
    @bindings.add("escape", "backspace")
    def delete_backward_word(event):
        get_by_name("backward-kill-word").call(event)

    # ctrl-backspace
    @bindings.add("\x08", filter=insert_mode)
    def delete_backward_big_word(event):
        get_by_name("unix-word-rubout").call(event)

    # alt-delete
    @bindings.add("escape", "delete", filter=insert_mode)
    def delete_word(event):
        get_by_name("kill-word").call(event)

    # control-delete
    # adjusted from https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/src/prompt_toolkit/key_binding/bindings/named_commands.py#L368
    @bindings.add("c-delete", filter=insert_mode)
    def delete_big_word(event):
        buff = event.current_buffer
        pos = buff.document.find_next_word_ending(count=event.arg, WORD=True)
        if pos:
            _deleted = buff.delete(count=pos)
            # Crashing on WSL2:
            # if event.is_repeat:
            #     deleted = event.app.clipboard.get_data().text + deleted
            # event.app.clipboard.set_text(deleted)
