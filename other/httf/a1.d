import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int[100][100] AS;

alias Ver = Tuple!(int, "x", int, "y");

void main()
{
    foreach (i; 0..100) {
        auto as = readln.split;
        foreach (j, a; as) {
            AS[j][i] = a.to!int;
        }
    }

    // 頂点を探す
    Ver[] VS;
    foreach (i; 0..100) {
        foreach (j; 0..100) {
            auto f = true;
            if (i > 0) f &= AS[i][j] > AS[i-1][j];
            if (i < 99) f &= AS[i][j] > AS[i+1][j];
            if (j > 0) f &= AS[i][j] > AS[i][j-1];
            if (j < 99) f &= AS[i][j] > AS[i][j+1];
            if (f) VS ~= Ver(j, i);
        }
    }
    foreach (i, v; VS) {
        if (i != VS.length-1)
            foreach (ref v_; VS[i+1..$]) {
                auto d = AS[v.y][v.x] - (abs(v.x - v_.x) + abs(v.y - v_.y));
                AS[v_.y][v_.x] -= d > 0 ? d : 0;
            }
    }
    writeln(VS.length);
    foreach (v; VS) {
        writefln("%d %d %d", v.x, v.y, AS[v.x][v.y]);
    }
}