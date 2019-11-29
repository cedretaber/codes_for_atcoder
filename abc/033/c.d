import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    int cnt;
    bool has_zero;
    foreach (i, c; S) {
        if (i%2 && c == '+') {
            if (!has_zero) ++cnt;
            has_zero = false;
        } else if (c == '0') {
            has_zero = true;
        }
    }
    writeln(cnt + (has_zero ? 0 : 1));
}