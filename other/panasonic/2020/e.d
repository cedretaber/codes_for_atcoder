import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

bool eq(char a, char b) {
    return a == '?' || b == '?' || a == b;
}

void main()
{
    auto a = readln.chomp.to!(char[]);
    auto b = readln.chomp.to!(char[]);
    auto c = readln.chomp.to!(char[]);
    auto A = a.length.to!int;
    auto B = b.length.to!int;
    auto C = c.length.to!int;
    bool[20000] ab, ac, bc;
    ab[] = true;
    ac[] = true;
    bc[] = true;
    foreach (i; 0..A) foreach (j; 0..B) if (!eq(a[i], b[j])) ab[i-j + 10000] = false;
    foreach (i; 0..A) foreach (j; 0..C) if (!eq(a[i], c[j])) ac[i-j + 10000] = false;
    foreach (i; 0..B) foreach (j; 0..C) if (!eq(b[i], c[j])) bc[i-j + 10000] = false;

    auto r = int.max;
    foreach (i; -4000..4001) foreach (j; -4000..4001) {
        if (ab[i+10000] && ac[j+10000] && bc[j-i+10000]) {
            r = min(r, max(A, i+B, j+C)-min(0, i, j));
        }
    }
    writeln(r);
}