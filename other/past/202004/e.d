import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    int[] rs;
    foreach (i; 0..N) {
        auto as = AS.dup;
        auto org = as[i];
        int j;
        do {
            j += 1;
            as[i] = AS[as[i]-1];
        } while (as[i] != org);
        rs ~= j;
    }
    writeln(rs.to!(string[]).join(" "));
}