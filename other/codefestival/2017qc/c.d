import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.chomp;
    size_t i, j = s.length-1;
    int c;
    while (j > i) {
        if (s[i] == s[j]) {
            ++i; --j;
        } else if (s[i] == 'x') {
            ++i; ++c;
        } else if (s[j] == 'x') {
            --j; ++c;
        } else {
            writeln(-1);
            return;
        }
    }
    writeln(c);
}