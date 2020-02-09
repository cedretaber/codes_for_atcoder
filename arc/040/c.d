import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    char[][] MAP;
    MAP.length = N;
    foreach (i; 0..N) MAP[i] = readln.chomp.to!(char[]);
    auto RS = new int[](N);
    RS[] = -1;
    foreach (i; 0..N) foreach (j, c; MAP[i]) if (c == '.') RS[i] = j.to!int;

    int ret;
    for (size_t i; i < N; ++i) {
        if (RS[i] >= 0) {
            ++ret;
            if (i == N-1) break;
            RS[i+1] = -1;
            foreach (j, c; MAP[i+1][0..RS[i]]) if (c == '.') RS[i+1] = j.to!int;
        }
    }
    writeln(ret);
}