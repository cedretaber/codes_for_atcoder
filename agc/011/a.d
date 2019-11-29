import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nck = readln.split.to!(int[]);
    auto N = nck[0];
    auto C = nck[1];
    auto K = nck[2];

    int[] TS;
    TS.length = N;
    foreach (i; 0..N) TS[i] = readln.chomp.to!int;
    sort(TS);

    int cnt, last_t, bs;
    foreach (t; TS) {
        if (!last_t) last_t = t;
        if (t > last_t + K || cnt == C) {
            ++bs;
            cnt = 0;
            last_t = t;
        }
        ++cnt;
    }
    writeln(bs+1);
}