import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto p = readln.chomp;
    if (p == "a" || p == "zzzzzzzzzzzzzzzzzzzz") {
        writeln("NO");
        return;
    }

    int n;
    foreach (c; p) n += c-'a'+1;
    char[] r;
    for (;;) {
        if (n > 26) {
            r ~= 'z';
            n -= 26;
        } else {
            r ~= (n+'a'-1).to!char;
            break;
        }
    }
    if (p == r) {
        r[0] -= 1;
        if (r[$-1] == 'z' || r.length == 1) {
            r ~= 'a';
        } else {
            r[$-1] += 1;
        }
    }
    writeln(r);
}