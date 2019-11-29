import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto l = readln.split.to!(int[]);
    auto H = l[0];
    auto W = l[1];
    auto A = l[2];
    auto B = l[3];

    char[][] R;
    R.length = H;

    foreach (h; 0..H) {
        foreach (w; 0..W) {
            bool x;
            if (h < B) x = !x;
            if (w < A) x = !x;
            R[h] ~= x ? '1' : '0';
        }
    }

    foreach (r; R) writeln(r);
}