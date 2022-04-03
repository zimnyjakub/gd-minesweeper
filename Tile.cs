using System;
using Godot;

internal enum TileState
{
    NotClicked = 0,
    BeingClicked = 1,
    Clicked = 2,
    Flagged
}

internal enum TileValue
{
    Empty = 0,
    One = 1,
    Two = 2,
    Three = 3,
    Four = 4,
    Five = 5,
    Six = 6,
    Seven = 7,
    Eight = 8,
    Nine = 9,

    Flag = 69,
    Mine = 420
}


public class Tile : Node2D
{
    private readonly Texture _downTexture = ResourceLoader.Load("res://tiles/down.tres") as Texture;
    private readonly Texture _flaggedTexture = ResourceLoader.Load("res://tiles/flag.tres") as Texture;

    private Sprite _sprite;
    [Export] private TileState _tileState = TileState.NotClicked;


    public override void _Ready()
    {
        _sprite = GetNode<Sprite>("Sprite");
        Connect("input_event", this, nameof(InputEvent));
    }

    private void InputEvent(Node viewport, InputEvent e, int shape_idx)
    {
        if (e.IsActionPressed("left_click"))
        {
            _tileState = TileState.BeingClicked;
            _sprite.Texture = _downTexture;
        }

        if (e.IsActionReleased("left_click"))
        {
            _tileState = TileState.Clicked;
            _sprite.Texture = _downTexture;
        }

        if (e.IsActionPressed("right_click"))
        {
            _tileState = TileState.Flagged;
            _sprite.Texture = _flaggedTexture;
        }
    }

    // public override void _PhysicsProcess(float delta)
    // {
    //     switch (_tileState)
    //     {
    //         case TileState.NotClicked:
    //
    //             break;
    //         case TileState.BeingClicked:
    //             GD.Print("being clicked");
    //             break;
    //         case TileState.Clicked:
    //             GD.Print("clicked");
    //             break;
    //         default:
    //             throw new ArgumentOutOfRangeException();
    //     }
    // }
}