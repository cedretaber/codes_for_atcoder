import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto K = readln.chomp.to!int;
    int[] ns;
    foreach (_; 0..N) ns ~= readln.chomp.to!int;
    sort(ns);
    bool[int] memo;
    int cnt;
    do {
        int x;
        foreach (n; ns[0..K]) {
            if (n > 9) {
                x *= 100;
            } else {
                x *= 10;
            }
            x += n;
        }
        if (x !in memo) {
            memo[x] = true;
            cnt += 1;
        }
    } while (nextPermutation(ns));
    writeln(cnt);
}