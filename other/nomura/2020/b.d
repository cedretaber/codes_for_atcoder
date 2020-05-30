import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    char[] r;
    foreach (c; readln.chomp) {
        if (c == '?') {
            r ~= 'D';
        } else {
            r ~= c;
        }
    }
    writeln(r);
}