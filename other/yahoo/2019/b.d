import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[2][6] pt;

void main()
{
    foreach (i; 0..3) {
        auto ab = readln.split.to!(int[]);
        pt[i] = [ab[0], ab[1]];
        pt[3+i] = [ab[1], ab[0]];
    }

    foreach (i, a; pt) {
        foreach (j, b; pt) {
            foreach (k, c; pt) {
                if (i%3 == j%3 || j%3 == k%3 || k%3 == i%3) continue;
                if (a[1] == b[0] && b[1] == c[0]) {
                    writeln("YES");
                    return;
                }
            }
        }
    }
    writeln("NO");
}