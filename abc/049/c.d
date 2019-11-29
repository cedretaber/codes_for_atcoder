import std.stdio, std.algorithm, std.conv, std.array, std.string;

enum DREAM = "dream";
enum DREAM_CNT = DREAM.length;
enum DREAMER = "dreamer";
enum DREAMER_CNT = DREAMER.length;
enum ERASE = "erase";
enum ERASE_CNT = ERASE.length;
enum ERASER = "eraser";
enum ERASER_CNT = ERASER.length;

void main()
{
    auto s = readln.chomp;

    while (!s.empty) {
        if (s.endsWith(DREAMER)) {
            s = s[0..$-DREAMER_CNT];
        } else if (s.endsWith(ERASER)) {
            s = s[0..$-ERASER_CNT];
        } else if (s.endsWith(DREAM)) {
            s = s[0..$-DREAM_CNT];
        } else if (s.endsWith(ERASE)) {
            s = s[0..$-ERASE_CNT];
        } else {
            writeln("NO");
            return;
        }
    }
    writeln("YES");
    return;
}