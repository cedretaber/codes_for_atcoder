import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ns = readln.split;
    foreach (a; ns) {
        foreach (b; ns) {
            foreach (c; ns) {
                foreach (d; ns) {
                    if (a~b~c~d == "1974") {
                        writeln("YES");
                        return;
                    }
                }
            }
        }
    }
    writeln("NO");
    return;
}