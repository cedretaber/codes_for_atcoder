import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto A = readln.chomp;
    auto B = readln.chomp;

    char[] as, bs;
    foreach (i; 0..A.length) if (A[i] != B[i]) {
        as ~= A[i];
        bs ~= B[i];
    }

    if (as.length == 0) {
        int[26] cs;
        foreach (c; A) ++cs[c-'a'];
        foreach (c; cs) if (c > 1) {
            writeln("YES");
            return;
        }
        writeln("NO");
        return;
    }

    if (as.length > 6) {
        writeln("NO");
        return;
    }

    while (as.length < 6 && as.length < A.length) {
        as ~= '.';
        bs ~= '.';
    }

    size_t[] ii;
    ii.length = 6;
    bool solve(size_t i) {
        if (i == 6) {
            auto cs = as.dup;
            swap(cs[ii[0]], cs[ii[1]]);
            swap(cs[ii[2]], cs[ii[3]]);
            swap(cs[ii[4]], cs[ii[5]]);
            return cs == bs;
        } else {
            foreach (j; 0..as.length) {
                if (i%2 == 1 && ii[i-1] == j) continue;
                ii[i] = j;
                if (solve(i+1)) return true;
            }
            return false;
        }
    }
    writeln(solve(0) ? "YES" : "NO");
}