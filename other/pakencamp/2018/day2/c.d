import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    foreach (i; 0..N) {
        auto bs = new int[](i+1);
        auto n = i+1;
        foreach (j; i+1..N) {
            if (as[j%n] && as[j] && as[j%n] != as[j]) goto ng;
            if (as[j%n] == 0 && as[j]) {
                if (bs[j%n] && bs[j%n] != as[j]) goto ng;
                bs[j%n] = as[j];
            }
        }
        writeln(i+1);
        return;
        ng:
    }
}