import std.stdio, std.string, std.conv, std.array, std.algorithm, std.range;

void main()
{
    auto n = readln.chomp.split(" ")[0].to!int;
    auto ds = readln.chomp.split(" ").map!(to!string).join("");

    bool check(string xs) {
        foreach (d; ds) {
            foreach (x; xs.uniq) {
                if (d == x) return true;
            }
        }
        return false;
    }

    while (check(n.to!string))
        ++n;

    writeln(n);
}