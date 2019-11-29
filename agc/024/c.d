import std.stdio, std.algorithm, std.conv, std.array, std.string;

int[(10^^5)*2] AS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) AS[i] = readln.chomp.to!int;

    if (AS[0]) {
        writeln("-1");
        return;
    }

    long cnt;
    foreach (i; 1..N) {
        if (AS[i] > AS[i-1]+1) {
            writeln("-1");
            return;
        }

        if (AS[i] == AS[i-1]+1) {
            ++cnt;
        } else {
            cnt += AS[i];
        }
    }

    writeln(cnt);
}