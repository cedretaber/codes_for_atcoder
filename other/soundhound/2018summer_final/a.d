import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto cd = readln.split.to!(long[]);
    auto C = cd[0];
    auto D = cd[1];

    long min_bpm = 140, max_bpm = 170, res;
    while (min_bpm <= D) {
        auto min_p = max(min_bpm, C);
        auto max_p = min(max_bpm, D);
        res += (max_p > min_p ? max_p - min_p : 0);
        min_bpm *= 2;
        max_bpm *= 2;
    }
    writeln(res);
}