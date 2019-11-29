import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5] R;
int[][10^^5] NS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto XS = readln.split.to!(int[]);
    if (M == 1) {
        writeln(N/2);
        return;
    }
    sort(XS);
    foreach (x; XS) {
        ++R[x%M];
        NS[x%M] ~= x;
    }
    int ans = R[0]/2;
    foreach (i; 1..(M+1)/2) {
        auto d = min(R[i], R[M-i]);
        ans += d;
        R[i] -= d;
        R[M-i] -= d;
    }
    if (M%2 == 0) {
        auto d = R[M/2]/2;
        ans += d;
        R[M/2] -= d*2;
    }
    foreach (i; 1..10^^5) {
        int c;
        for (int j; j < NS[i].length; ++j) {
            if (NS[i].length > j+1 && NS[i][j] == NS[i][j+1]) {
                ++c;
                ++j;
            }
        }
        ans += min(c, R[i]/2);
    }
    writeln(ans);
}