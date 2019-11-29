import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto s = readln.chomp.to!(dchar[]);
    int ni, co, max_p;
    foreach (c; s) {
        if (c == '2') {
            if (co)
                --co;
            else
                max_p = max(max_p, ++ni);
        } else {
            if (ni)
                --ni;
            else {
                writeln(-1);
                return;
            }
        }
    }
    writeln(ni || co ? -1 : max_p);
}