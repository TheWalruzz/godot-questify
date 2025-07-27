using Godot;
using System;

public static class Questify
{
  #region Questify Instance
  private static readonly NodePath nodePath = new("/root/Questify");
  private static Node instance;
  public static Node Instance
  {
    get
    {
      if (instance == null)
      {
        instance = ((SceneTree)Engine.GetMainLoop()).Root.GetNode(nodePath);
      }
      return instance;
    }
  }
  #endregion


  #region Methods
  public static Resource Instantiate(Resource questResource)
  {
    return (Resource)questResource.Call(FuncName.Instantiate);
  }

  public static void StartQuest(Resource quest, Godot.Collections.Dictionary questParams = new Godot.Collections.Dictionary())
  {
    Instance.Call(FuncName.StartQuest, quest, questParams);
  }

  public static void SetConditionCompleted(Resource questCondition, bool complete)
  {
    questCondition.Call(FuncName.SetConditionCompleted, complete);
  }

  public static void ToggleUpdatePolling(bool updatePolling)
  {
    Instance.Call(FuncName.ToggleUpdatePolling, updatePolling);
  }

  public static void UpdateQuests()
  {
    Instance.Call(FuncName.UpdateQuests);
  }

  public static Godot.Collections.Array<Resource> GetQuests()
  {
    return (Godot.Collections.Array<Resource>)Instance.Call(FuncName.GetQuests);
  }

  public static Godot.Collections.Array<Resource> GetActiveQuests()
  {
    return Instance.Call(FuncName.GetActiveQuests).As<Godot.Collections.Array<Resource>>();
  }

  public static Godot.Collections.Array<Resource> GetCompletedQuests()
  {
    return Instance.Call(FuncName.GetCompletedQuests).As<Godot.Collections.Array<Resource>>();
  }

  public static void SetQuests(Godot.Collections.Array<Resource> quests)
  {
    Instance.Call(FuncName.Clear);
    foreach (var quest in quests)
    {
      Instance.Call(FuncName.AddQuest, quest);
    }
  }

  public static Godot.Collections.Array Serialize()
  {
    return Instance.Call(FuncName.Serialize).As<Godot.Collections.Array>();
  }

  public static void Deserialize(Godot.Collections.Array data)
  {
    Instance.Call(FuncName.Deserialize, data);
  }

  public static string GetResourcePath(Resource quest)
  {
    return ((Resource)quest).Call(FuncName.GetResourcePath).As<string>();
  }

  public static void Clear()
  {
    Instance.Call(FuncName.Clear);
  }

  #endregion

  #region Signal Handlers
  /// <summary>
  /// Connect action to "quest_started" signal.
  /// </summary>
  /// <param name="action"></param>
  public static void ConnectQuestStarted(Action<Resource> action)
  {
    Instance.Connect(SignalName.QuestStarted, Callable.From(action));
  }

  /// <summary>
  /// Connect action to "quest_condition_query_requested" signal.
  /// </summary>
  /// <param name="action"></param>
  public static void ConnectConditionQueryRequested(Action<string, string, Variant, Resource> action)
  {
    Instance.Connect(SignalName.ConditionQueryRequested, Callable.From(action));
  }

  /// <summary>
  /// Connect action to "quest_objective_added" signal.
  /// </summary>
  /// <param name="action"></param>
  public static void ConnectQuestObjectiveAdded(Action<Resource, Resource> action)
  {
    Instance.Connect(SignalName.QuestObjectiveAdded, Callable.From(action));
  }

  /// <summary>
  /// Connect action to "quest_objective_completed" signal.
  /// </summary>
  /// <param name="action"></param>
  public static void ConnectQuestObjectiveCompleted(Action<Resource, Resource> action)
  {
    Instance.Connect(SignalName.QuestObjectiveCompleted, Callable.From(action));
  }

  /// <summary>
  /// Connect action to "quest_completed" signal.
  /// </summary>
  /// <param name="action"></param>
  public static void ConnectQuestCompleted(Action<Resource> action)
  {
    Instance.Connect(SignalName.QuestCompleted, Callable.From(action));
  }

  #endregion

  #region Reference Names
  private static class FuncName
  {
    public static readonly StringName StartQuest = "start_quest";
    public static readonly StringName Instantiate = "instantiate";
    public static readonly StringName SetConditionCompleted = "set_completed";
    public static readonly StringName ToggleUpdatePolling = "toggle_update_polling";
    public static readonly StringName UpdateQuests = "update_quests";
    public static readonly StringName GetQuests = "get_quests";
    public static readonly StringName GetActiveQuests = "get_active_quests";
    public static readonly StringName GetCompletedQuests = "get_completed_quests";
    public static readonly StringName AddQuest = "add_quest";
    public static readonly StringName SetQuests = "set_quests";
    public static readonly StringName Serialize = "serialize";
    public static readonly StringName Deserialize = "deserialize";
    public static readonly StringName GetResourcePath = "get_resource_path";
    public static readonly StringName Clear = "clear";
  }

  private static class SignalName
  {
    public static readonly StringName QuestStarted = "quest_started";
    public static readonly StringName ConditionQueryRequested = "condition_query_requested";
    public static readonly StringName QuestObjectiveAdded = "quest_objective_added";
    public static readonly StringName QuestObjectiveCompleted = "quest_objective_completed";
    public static readonly StringName QuestCompleted = "quest_completed";
  }
  #endregion

}
