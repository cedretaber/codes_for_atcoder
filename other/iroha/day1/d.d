import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nxy = readln.split.to!(int[]);
    auto X = nxy[1];
    auto Y = nxy[2];
    auto AS = readln.split.to!(int[]);
    sort!"a > b"(AS);
    foreach (i, a; AS) {
        if (i%2 == 0) {
            X += a;
        } else {
            Y += a;
        }
    }
    writeln(X == Y ? "Draw" : X > Y ? "Takahashi" : "Aoki");
}