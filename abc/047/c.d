import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto s = readln.chomp;
    auto cnt = 0;
    char last = s[0];
    foreach (c; s[1..$]) {
        if (c != last) {
            ++cnt;
            last = c;
        }
    }
    writeln(cnt);
}