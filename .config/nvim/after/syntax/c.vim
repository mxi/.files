syn match cTodo /@SECTION\((\w*):\)\?/

syn match cTodo /@NOTE\((\w*):\)\?/
syn match cTodo /@WARN\((\w*):\)\?/

syn match cTodo /@TODO/
syn match cTodo /@GLOBAL/
syn match cTodo /@TUNABLE/
syn match cTodo /@SPEED/

syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
