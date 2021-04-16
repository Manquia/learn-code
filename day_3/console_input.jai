// WINDOWS ONLY

// Returns a single line of input from the console
// This call is blocking so it will not return until
// it has recieved input.
// 
// Be sure to call free() on the string once you're done with it.
get_line :: () -> string 
{
    MAX_BYTES_TO_READ :: 1024;
    temp : [MAX_BYTES_TO_READ] u8;
    result: string = ---;
    bytes_read : s32;

    if !stdin_ready
    {
        stdin_ready = true;
        stdin = GetStdHandle( STD_INPUT_HANDLE );
    }
    
    if !ReadConsoleA( stdin, temp.data, xx temp.count, *bytes_read )
        return "";

    // trim any spaces, newlines, or Carrage Returns (CR)
    result.data  = temp.data;
    result.count = bytes_read;
    result = trim(result, " \n\r");

    // allocate return buffer
    result.data  = alloc(result.count);
    memcpy(result.data, temp.data, result.count);
    return result;
}

#scope_file
#import "Windows";
#import "String";
#import "Basic";

kernel32 :: #foreign_system_library "kernel32";

stdin_ready: bool;
stdin  : HANDLE;
stdout_ready: bool;
stdout : HANDLE;

ReadConsoleA  :: (hConsoleHandle: HANDLE, buff : *u8, chars_to_read : s32,  chars_read : *s32, lpInputControl := *void ) -> BOOL #foreign kernel32;