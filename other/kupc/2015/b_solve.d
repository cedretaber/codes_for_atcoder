import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    foreach (i1; 0..10)
    foreach (i2; 0..10)
    foreach (i3; 0..10)
    foreach (i4; 0..10)
    foreach (j1; 0..10)
    foreach (j2; 0..10)
    foreach (j3; 0..10)
    foreach (j4; 0..10) {
        auto MAP = new int[][](10, 10);
        foreach (ij; [[i1, j1], [i2, j2], [i3, j3], [i4, j4]]) {
            foreach (d; [
                [0,0],
                [1,0],[0,1],[-1,0],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1],
                [2,0],[0,2],[-2,0],[0,-2],[2,2],[2,-2],[-2,2],[-2,-2]
            ]) {
                auto i = ij[0] + d[0];
                auto j = ij[1] + d[1];
                if (i < 0 || i >= 10 || j < 0 || j >= 10) continue;
                MAP[i][j] = -1;
            }
        }
        foreach (i; 0..10) if (MAP[i][0] != -1) MAP[i][0] = 1;
        foreach (j; 0..9) foreach (i; 0..10) if (MAP[i][j] != -1) {
            foreach (d; [-1, 0, 1]) if (i+d >= 0 && i+d < 10 && MAP[i+d][j+1] != -1) {
                MAP[i+d][j+1] += MAP[i][j];
            }
        }

        bool has_one, ok = true;
        foreach (i; 0..10) {
            if (MAP[i][9] > 1) {
                ok = false;
                break;
            } else if (MAP[i][9] == 1) {
                if (has_one) {
                    ok = false;
                    break;
                }
                has_one = true;
            }
        }
        if (ok && has_one) {
            writefln("(%d, %d) (%d, %d) (%d, %d) (%d, %d)", j1+1, i1+1, j2+1, i2+1, j3+1, i3+1, j4+1, i4+1);
            writeln(MAP);
        }
    }
}