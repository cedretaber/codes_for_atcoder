import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);

    long[] BS;
    BS.length = N + 1;

    foreach (i, a; AS) {
        BS[i+1] = BS[i] + a;
    }

    long[long] memo;
    foreach (b; BS) {
        if (b in memo) {
            ++memo[b];
        } else {
            memo[b] = 1;
        }
    }
    long r;
    foreach (_, n; memo) {
        r += n * (n-1) / 2;
    }
    writeln(r);
}