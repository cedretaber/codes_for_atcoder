import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    int a, b, c;
    readf("%d %d %d", &a, &b, &c);

    auto r = a%b;
    while (r != 0) {
        if (c >= r && c%r == 0) {
            writeln("YES");
            return;
        } else {
            while (r < b) r += a;
            r = r % b;
        }
    }
    writeln(c == 0 ? "YES" : "NO");
}