import std.stdio, std.string, std.array, std.conv, std.algorithm.iteration, std.functional;

long[10^^5+1] AS;

void main()
{
    readln;
    auto as = readln.split.to!(long[]);
    foreach (a; as) ++AS[a];
    
    auto cnt = as.length;
    size_t i = 1, j = 10^^5+1;
    for (; j > i && i < 10^^5+1 && j > 0;) {
        if (AS[i] > 2) {
            AS[i] -= 2;
            cnt -= 2;
        } else if (AS[i] == 2) {
            if (AS[j] < 2) {
                --j;
            } else if (AS[j] > 2) {
                AS[j] -= 2;
                cnt -= 2;
            } else {
                --AS[i];
                --AS[j];
                cnt -= 2;
            }
        } else {
            ++i;
        }
    }
    while (AS[i] > 1) {
        AS[i] -= 2;
        cnt -= 2;
    }
    while (AS[j] > 1) {
        AS[j] -= 2;
        cnt -= 2;
    }
    writeln(cnt);
}