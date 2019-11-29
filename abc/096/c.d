import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

auto DS = [[1,0], [-1,0], [0,1], [0,-1]];

wchar[50][50] MAP;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    foreach (i; 0..H) {
        foreach (j, c; readln.chomp.to!(wchar[])) {
            MAP[i][j] = c;
        }
    }

    foreach (y, line; MAP[0..H]) {
        foreach (x, c; line[0..W]) {
            if (c == '#') {
                bool valid;
                foreach (d; DS) {
                    auto xd = x + d[0];
                    auto yd = y + d[1];
                    if (xd < 0 || xd >= W || yd < 0 || yd >= H) continue;
                    if (MAP[yd][xd] == '#') {
                        valid = true;
                        break;
                    }
                }
                if (!valid) {
                    writeln("No");
                    return;
                }
            }
        }
    }

    writeln("Yes");
}