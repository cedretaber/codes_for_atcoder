import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xy = readln.split.to!(long[]);
    auto x = xy[0];
    auto y = xy[1];
 
    if (y > x) {
        if (x < 0 && y > 0) {
            writeln(min(y - x, abs(y + x) + 1));
        } else {
            writeln(y - x);
        }
    } else {
        if (x == 0) {
            writeln(-y + 1);
        } else if (y == 0) {
            writeln(x + 1);
        } else if (x > 0 && y > 0) {
            writeln(min(x - y + 2, x + y + 1));
        } else if (x > 0 && y < 0) {
            writeln(abs(x + y) + 1);
        } else {
            writeln(min(-y + x + 2, -x - y + 1));
        }
    }
}