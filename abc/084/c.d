import std.stdio, std.algorithm, std.conv, std.array, std.string;

int[500] CS;
int[500] SS;
int[500] FS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N-1) {
        auto csf = readln.split.to!(int[]);
        CS[i] = csf[0];
        SS[i] = csf[1];
        FS[i] = csf[2];
    }

    foreach (s; 0..N-1) {
        int t = 0;
        foreach (i; s..N-1) {
            if (t <= SS[i]) {
                t = SS[i] + CS[i];
            } else {
                auto d = t % FS[i];
                t += (FS[i] - t % FS[i]) % FS[i] + CS[i];
            }
        }
        writeln(t);
    }
    writeln(0);
}