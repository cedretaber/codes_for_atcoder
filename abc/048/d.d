import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto s = readln.chomp;

    char fs = s[0];
    char sc = s[1];

    long cnt = 0;
    foreach (c; s[2..$]) {
        if (fs == c) {
            ++cnt;
            fs = sc;
            sc = c;
        }
    }

    writeln((cnt&1) == 0 ? "First" : "Second");
}