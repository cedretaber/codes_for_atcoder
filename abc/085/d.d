import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

alias AB = Tuple!(int, bool);

int N, H;
AB[(10^^5)*2] ABS;

void main()
{
    readf("%d %d", &N, &H);
    int a, b;
    foreach (i; 0..N) {
        readf(" %d %d", &a, &b);
        ABS[i] = AB(a, true);
        ABS[N+i] = AB(b, false);
    }

    ABS[].sort!"a[0] > b[0]";

    int cnt;
    foreach (ab; ABS) {
        if (ab[1]) {
            cnt += (H+ab[0]-1)/ab[0];
            break;
        } else {
            cnt++;
            H -= ab[0];
            if (H <= 0) break;
        }
    }
    writeln(cnt);
}