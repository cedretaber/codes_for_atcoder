import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    wchar[][] MAP;
    MAP.length = N;
    foreach (ref line; MAP) {
        auto cs = readln.chomp.to!(wchar[]);
        line = cs ~ cs;
    }

    int cnt;
    foreach (o; 0..N) {
        void check() {
            foreach (i; 0..N) {
                foreach (j; i..N) {
                    if (MAP[i][o+j] != MAP[j][o+i]) return;
                }
            }
            ++cnt;
        }
        check();
    }
    writeln(cnt * N);
}