import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto ss = readln.chomp;

    while (ss) {
        ss = ss[0..$-2];
        auto l = ss.length;

        if (ss[0..l/2] == ss[l/2..$]) {
            writeln(l);
            return;
        }
    }
}