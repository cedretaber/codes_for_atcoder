import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto len = readln.chomp.to!long;
    auto as = readln.split;

    string[] ret;
    ret.length = len;
    size_t p = len / 2;
    auto v = len & 1 ? 1 : -1;

    foreach (i, a; as) {
        v = -v;
        p += i * v;
        ret[p] = a;
    }

    writeln(ret.join(" "));
}