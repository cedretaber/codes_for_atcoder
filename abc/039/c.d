import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum Do = "WBWBWWBWBWBWWBWBWWBW";
enum Re = "WBWWBWBWBWWBWBWWBWBW";
enum Mi = "WWBWBWBWWBWBWWBWBWBW";
enum Fa = "WBWBWBWWBWBWWBWBWBWW";
enum So = "WBWBWWBWBWWBWBWBWWBW";
enum La = "WBWWBWBWWBWBWBWWBWBW";
enum Si = "WWBWBWWBWBWBWWBWBWWB";

void main()
{
    auto S = readln.chomp;
    string s;
    if (S == Do) {
        s = "Do";
    } else if (S == Re) {
        s = "Re";
    } else if (S == Mi) {
        s = "Mi";
    } else if (S == Fa) {
        s = "Fa";
    } else if (S == So) {
        s = "So";
    } else if (S == La) {
        s = "La";
    } else {
        s = "Si";
    }
    writeln(s);
}